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
2018-09-04):

``` r
collections <- geomet_collection()

collections[,c("title", "name")]
#> # A tibble: 5 x 2
#>   title                                            name                   
#>   <chr>                                            <chr>                  
#> 1 Monthly Mean of Water Level or Flow              hydrometric-monthly-me~
#> 2 Annual Maximum and Minimum Instantaneous Water ~ hydrometric-annual-pea~
#> 3 Annual Maximum and Minimum Daily Water Level or~ hydrometric-annual-sta~
#> 4 Hydrometric Monitoring Stations                  hydrometric-stations   
#> 5 Daily Mean of Water Level or Flow                hydrometric-daily-mean
```

For instance daily mean value can be queried using:

``` r
geomet_daily_mean(station_number = "08MF005")
#> OK
#> Simple feature collection with 10000 features and 12 fields
#> geometry type:  POINT
#> dimension:      XY
#> bbox:           xmin: -121.4542 ymin: 49.38596 xmax: -121.4542 ymax: 49.38596
#> epsg (SRID):    4326
#> proj4string:    +proj=longlat +datum=WGS84 +no_defs
#> # A tibble: 10,000 x 13
#>    id    station_number level level_symbol_en  flow flow_symbol_en
#>    <chr> <chr>          <dbl> <chr>           <dbl> <chr>         
#>  1 08MF~ 08MF005         2.96 <NA>              479 <NA>          
#>  2 08MF~ 08MF005         2.93 <NA>              459 <NA>          
#>  3 08MF~ 08MF005         2.93 <NA>              459 <NA>          
#>  4 08MF~ 08MF005         2.90 <NA>              439 <NA>          
#>  5 08MF~ 08MF005         2.93 <NA>              459 <NA>          
#>  6 08MF~ 08MF005         2.96 <NA>              479 <NA>          
#>  7 08MF~ 08MF005         3.32 <NA>              716 <NA>          
#>  8 08MF~ 08MF005         3.41 <NA>              787 <NA>          
#>  9 08MF~ 08MF005         3.41 <NA>              787 <NA>          
#> 10 08MF~ 08MF005         3.66 <NA>              991 <NA>          
#> # ... with 9,990 more rows, and 7 more variables: flow_symbol_fr <chr>,
#> #   level_symbol_fr <chr>, date <date>, station_name <chr>,
#> #   identifier <chr>, prov_terr_state_loc <chr>, geometry <POINT [Â°]>
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

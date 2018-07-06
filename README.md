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

``` r
library(geometr)
geomet_stations(station_number = "08MF005")
#> # A tibble: 1 x 11
#>   CONTRIBUTOR_FR STATUS_EN STATION_NUMBER CONTRIBUTOR_EN    VERTICAL_DATUM
#> * <lgl>          <chr>     <chr>          <chr>             <chr>         
#> 1 NA             Active    08MF005        WATER SURVEY OF ~ ASSUMED DATUM 
#> # ... with 6 more variables: STATUS_FR <chr>, STATION_NAME <chr>,
#> #   IDENTIFIER <chr>, PROV_TERR_STATE_LOC <chr>, LATITUDE <dbl>,
#> #   LONGITUDE <dbl>
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

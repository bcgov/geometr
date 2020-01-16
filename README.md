<a id="devex-badge" rel="Retired" href="https://github.com/BCDevExchange/assets/blob/master/README.md"><img alt="No longer being used or supported, recommend not using an alternative option." style="border-width:0" src="https://assets.bcdevexchange.org/images/badges/retired.svg" title="No longer being used or supported, recommend not using an alternative option." /></a>

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
2019-03-15):

``` r
collections <- geomet_collection()

collections
#> # A tibble: 15 x 6
#>    title          name      description           extent crs        links  
#>    <chr>          <chr>     <chr>                 <list> <chr>      <list> 
#>  1 Monthly Mean ~ hydromet~ The monthly mean is ~ <int ~ http://ww~ <data.~
#>  2 Hydrometric M~ hydromet~ A station is a site ~ <int ~ http://ww~ <data.~
#>  3 Adjusted and ~ ahccd-st~ Adjusted and Homogen~ <int ~ http://ww~ <data.~
#>  4 Daily Mean of~ hydromet~ The daily mean is th~ <int ~ http://ww~ <data.~
#>  5 Adjusted and ~ ahccd-an~ Adjusted and Homogen~ <int ~ http://ww~ <data.~
#>  6 Annual Maximu~ hydromet~ The annual maximum a~ <int ~ http://ww~ <data.~
#>  7 Adjusted and ~ ahccd-se~ Adjusted and Homogen~ <int ~ http://ww~ <data.~
#>  8 Adjusted and ~ ahccd-tr~ Adjusted and Homogen~ <int ~ http://ww~ <data.~
#>  9 Coupled Model~ cmip5     Coupled Model Interc~ <int ~ http://ww~ <data.~
#> 10 MSC Monthly D~ climate-~ MSC Monthly Data      <int ~ http://ww~ <data.~
#> 11 Annual Maximu~ hydromet~ The annual maximum a~ <int ~ http://ww~ <data.~
#> 12 1981-2010 Cli~ climate-~ 1981-2010 Climate No~ <int ~ http://ww~ <data.~
#> 13 Climate Stati~ climate-~ Climate Stations      <int ~ http://ww~ <data.~
#> 14 MSC Daily Data climate-~ MSC Daily Data        <int ~ http://ww~ <data.~
#> 15 Adjusted and ~ ahccd-mo~ Adjusted and Homogen~ <int ~ http://ww~ <data.~
```

The envisioned API is a `geomet_data`. Currently only hydrometric is
supported:

``` r
geomet_data(parameter = "hydrometric-daily-mean", station_number = "10PC003", start_date = "1983-07-04")
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

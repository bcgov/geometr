# Copyright 2018 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.



## Parsing helpers for a basic output
tibble_parse <- function(parsed_txt) {

  ## Iterate over paginated results
  parsed <- purrr::map_dfr(parsed_txt, parsing_helper)

  ## Extract the list column which contains the coords
  coords <- as.data.frame(do.call(rbind, parsed$coordinates))

  ## Get rid of the original list column
  parsed$coordinates <- NULL
  parsed$type <- NULL

  colnames(coords) <- c("LONGITUDE","LATITUDE")

  ## Add the new separate columns to data
  no_spatial_parsed <- cbind(parsed, coords)

  if("DATE" %in% colnames(no_spatial_parsed)){
    ## Parse date correctly
    no_spatial_parsed$DATE <- as.Date(no_spatial_parsed$DATE, format="%Y-%m-%d")
    ## Sort by date
    no_spatial_parsed <- no_spatial_parsed[order(no_spatial_parsed$DATE),]
  }

  ## All lower case
  colnames(no_spatial_parsed) <- tolower(colnames(no_spatial_parsed))

  dplyr::as_tibble(no_spatial_parsed)

}


parsing_helper <- function(x){
  list_obj <- jsonlite::fromJSON(x)

  geometry_obj <- list_obj$features$geometry

  properties_obj <- list_obj$features$properties

  cbind(properties_obj, geometry_obj)

}

spatial_parse <- function(parsed_txt, ...) {
  #browser()

  spatial_parsed <- sf::read_sf(parsed_txt, stringsAsFactors = FALSE, quiet = TRUE, ...)

  if("DATE" %in% colnames(spatial_parsed)){
    ## Sort by date
    spatial_parsed <- spatial_parsed[order(spatial_parsed$DATE),]
  }

  ## All lower case
  colnames(spatial_parsed) <- tolower(colnames(spatial_parsed))

  return(spatial_parsed)

}
